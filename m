From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Documentation/git-send-email: Add "Use gmail as the smtp 
	server"
Date: Sun, 25 Apr 2010 01:03:27 +0200
Message-ID: <h2vfabb9a1e1004241603pc1371c18h84c012a51a085837@mail.gmail.com>
References: <1272094442-26485-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 01:03:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5oOA-0005DK-4j
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 01:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab0DXXDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 19:03:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:39256 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab0DXXDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 19:03:48 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1612324fga.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=287gfWB65Vk5c1leetmV0DjZwC7xl4WDNV9ngOeqPHU=;
        b=ej5lQbLTEGihyTw6iD5kG+5LroAAP+wkYw5zI1wPvwgQjtNxXJ6BiFZTpdOZJX0UmR
         uZy0DyyKVpGE9m9mIf5pOfAnOIXFRvMlIOX7XbFyF72NYuifwHBuyQmVG1zwOoMHw1cd
         CITgyoFAA0+cDKGC09PCylIMQcTnRUrqlZUEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=p0u2BoQJgW366ip9x8umKT5cQ2Sw/10tRTPSruxxCocj2Yoh9PQVJFWw/m469CwLpT
         YqXMAvN96tvFzFSbDpDH6ESfELJCC9E1woRMP+EszLRKl4hnlbrgnnbZp/C9KGDR6fpk
         nO9GfQab7rngirP0fc30JA7TYplB13ZjZogrY=
Received: by 10.102.243.26 with SMTP id q26mr1102828muh.34.1272150227084; Sat, 
	24 Apr 2010 16:03:47 -0700 (PDT)
Received: by 10.103.168.14 with HTTP; Sat, 24 Apr 2010 16:03:27 -0700 (PDT)
In-Reply-To: <1272094442-26485-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145709>

Heya,

On Sat, Apr 24, 2010 at 09:34, Ping Yin <pkufranky@gmail.com> wrote:
> +Use gmail as the smtp server

I use this setup myself, and I think it's very convenient to have this
in there, so fwiw:

Acked by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
