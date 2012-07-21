From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: git with large files...
Date: Sat, 21 Jul 2012 17:53:39 +0200
Message-ID: <CA+EOSBkVh-PvASXf5NOOW40MWzt4gdBm-21ER1EbUWLkCJ3cCA@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
	<CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
	<CA+EOSBk8XjA5=BO_kVOmfCPT-n2vKV1rbqUHnOnGi-ORF7wKLw@mail.gmail.com>
	<CACPiFCLTPi5i3RZHwOD-+OJ_zSbtOwe7VLy=NMO1MUKPVyPHEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Martin Langhoff <martin.langhoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 17:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssc01-0006Tq-5e
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab2GUPxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:53:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59531 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab2GUPxk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:53:40 -0400
Received: by pbbrp8 with SMTP id rp8so8043455pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=3BRFU52QAqlOwxlhzQAg6w1E7RGkS2lyfcgosAmRLjY=;
        b=zwBT3UUScCwywCAwwplhlX3LeOIJ8tlfzarsgRkGvUeLmuRa0czKTy+eYtnWtQTjvh
         mcu1oYyqZisfbPRnalTWLe1BiRux+gAH1kiAxSpYJckG5u3bJJQ9Oa+hdTdrptRX4rmz
         ME0S1PicDSauDm2sW3C7Rrfr/W9pq/gt8DXorN79um+R7inLBaNrqru3Xn7Tm/3UEMiK
         xYxXiZXR6LLBmmjjMUuUV4oXTn1wQj6lOJSVQyEBtFP1axiKfeFQen+UH8X7hUqrkgVN
         7U66NCm23ZcsuucW6LIBTkkgxOTduGPQYWiLf2OFakL8CTg4cPPX3ziJKEo42NmXckNj
         M1QQ==
Received: by 10.68.238.232 with SMTP id vn8mr22460135pbc.78.1342886019631;
 Sat, 21 Jul 2012 08:53:39 -0700 (PDT)
Received: by 10.66.157.97 with HTTP; Sat, 21 Jul 2012 08:53:39 -0700 (PDT)
In-Reply-To: <CACPiFCLTPi5i3RZHwOD-+OJ_zSbtOwe7VLy=NMO1MUKPVyPHEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201821>

Sure . There is a complete paragraph " creating decentralized puppet
architecture" in "puppet 2.7 cookbook". I am also sure to have read
the same topic on web on the site bitfieldconsulting.com  , not
casually : the book's author have his blog there. Sorry i have not the
complete url now - old smartphone, no wifi etc. But i hope this can
help you the  same.

Best regards

2012/7/21, Martin Langhoff <martin.langhoff@gmail.com>:
> On Sat, Jul 21, 2012 at 3:11 AM, Elia Pinto <gitter.spiros@gmail.com>
> wrote:
>> Well, many folks use puppet in serverless configuration pushing the
>> manifest from a central git server via cron and applying locally the
>> configuration fetched. In this sense git IS used for deployement. And,
>> for a configuration management system as puppet this could be a
>> sensible thing to do - reduce load, scalability ecc.
>
> That's a great thing to know, and timely too. I am looking at Puppet,
> and worried a bit about reported memory load on the server side (and
> some rumours of memory footprint issues on the client side too).
>
> Can you point me to more information & discussion?
>
> thanks!
>
>
>
> m
> --
>  martin.langhoff@gmail.com
>  martin@laptop.org -- Software Architect - OLPC
>  - ask interesting questions
>  - don't get distracted with shiny stuff  - working code first
>  - http://wiki.laptop.org/go/User:Martinlanghoff
>

-- 
Inviato dal mio dispositivo mobile
