From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH/RFC 00/20] Refactor rebase
Date: Thu, 25 Nov 2010 21:23:31 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011252120450.17721@debian>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 03:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnyD-00036U-Bp
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 03:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab0KZCXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 21:23:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52640 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab0KZCXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 21:23:18 -0500
Received: by vws3 with SMTP id 3so352906vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 18:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=LKAEWw/5ncjzS88+WLa+v2IHyBRROq9aS8cugAedZJw=;
        b=MH3E2X8oQsLynFzh1C1CgdnqWEXuhaGwW5YxaECDH/4mXsiC4Vd+XGwvHb7kkaEcUL
         zKCxNuCWNxlkgxvpCpZ3ui+4+jg46QEaMXlNSKZr1N8uN3WtzWXc2w8pqa4zP/IUXSnW
         Rm+6TkGUhrcxm9gKhS6TKu+OZEMd4/zVWaAm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=koYAJLxc++0AqSCJWx2RAbhMkFWL56lLou+R0E5/QiAGUbVb+mwiGBJf0QJhsINXad
         iBMBg/Y8Hswd8uxov5Mu4MNsW2cum+pmIOQ4XYLG5yknpJX4rpYQgcxL9MHIOhGpcXbB
         AIaMcLfmkmtRaoao6DdKMQW5VI+0MoTTRssqU=
Received: by 10.220.194.6 with SMTP id dw6mr336479vcb.276.1290738197318;
        Thu, 25 Nov 2010 18:23:17 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id fs21sm411957vbb.0.2010.11.25.18.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 18:23:16 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162181>


I forgot to say that the patches should be applied on pu.

/Martin
