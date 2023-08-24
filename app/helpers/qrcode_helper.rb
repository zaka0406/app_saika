module QrcodeHelper
    require 'rqrcode'

    def qrcode
        qrcode = RQRCode::QRCode.new("https://lin.ee/HnKGMGG")
        svg = qrcode.as_svg(
          color: "000",
          shape_rendering: "crispEdges",
          module_size: 2,
          standalone: true,
          use_path: true
        ).html_safe
      end

end