From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Force commit date
Date: Thu, 29 Jan 2009 19:37:25 +0100
Message-ID: <bd6139dc0901291037h46a75446occ3004d2ff58d889@mail.gmail.com>
References: <1233253817209-2240539.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Thu Jan 29 19:38:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSbmv-0001VF-FI
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 19:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbZA2Sh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 13:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZA2Sh1
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 13:37:27 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:40331 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZA2Sh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 13:37:26 -0500
Received: by yw-out-2324.google.com with SMTP id 9so29612ywe.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 10:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=eXYYC0XI39+vIdLnqF+uVY920pVkGIWyLUrmJSCj0gU=;
        b=wm0924PaHTm5CulPSzKsBMosDF3s4z4zLlS8a+yH74tf9uOENzswshcMYf5bv9W6CY
         LLLFGlayjIfgu94rZ/9oPD1unEOc+6uZxOaFyuqd+xckqQLeHbJ9f3GcdR++ksBETqQ3
         BGlA5kKfbm1Wzjznwuy/f78P54Y41OzW9rVEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=XMScVvAkxC9UajGVBw2XYGmJL8XRD6dQBC7t/dcC9B42xSZ20raREGOmkWGJJv8jOr
         h6roN2EfHYYv6nUj5T1+0ShnAWJy9re6k06HBA/iOx9PNDZGyc2bfMxbX8qwWj/EdtCe
         sG3f00QWMaCuN0f8DemlU8cwZWcFMOsINK4o8=
Received: by 10.151.143.3 with SMTP id v3mr358553ybn.109.1233254245437; Thu, 
	29 Jan 2009 10:37:25 -0800 (PST)
In-Reply-To: <1233253817209-2240539.post@n2.nabble.com>
X-Google-Sender-Auth: ecc251a1ed179559
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107709>

On Thu, Jan 29, 2009 at 19:30, Zabre <427@free.fr> wrote:
> There might be an option I am not aware of.

Indeed, try 'import-tars.perl' in the /contrib directory of git.git :).

-- 
Cheers,

Sverre Rabbelier
