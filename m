From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2010" - features used,
 features wanted
Date: Sun, 15 Aug 2010 17:13:27 -0500
Message-ID: <20100815221327.GB2666@burratino>
References: <201008152357.29889.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 00:15:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OklU0-0006ky-1K
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 00:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab0HOWPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 18:15:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52262 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0HOWPE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 18:15:04 -0400
Received: by yxg6 with SMTP id 6so1692413yxg.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=yge65tvPDg5zFukvQv5tXBEMPFs5Wie40sTr0GIRR+E=;
        b=AD04qD21ifQ3J9OZ7BwH+MP3uAkJL24iiZoStZKQ0fya6+gXI1ooC5DBSiHhuFDn0v
         43AhbN1JCmJBrfenknWY8TN6KY0B9yiGK6M1uHoZdMCCejIDzmPQjsd90t48USdPlI8s
         YCMdLzBO7wsTMzCU0q5u9xTXPMDTNCDlWFHuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qgKmNEu4GJUG1eZNL5QcICgvR89Z+ec4E3HC/5jLsz9Kc/Q5xOaO1cOCfh61HPZHSX
         DFmiYidBykHtnTWzyLtsqcODyEdGpAaXJv4y/knqfvFluwqAfgp/d8mGLmzhkzLlkwHJ
         LxJW1Ir3OIzGvwHs0rBbthiob86icezOg3r2M=
Received: by 10.150.144.3 with SMTP id r3mr3593528ybd.127.1281910503002;
        Sun, 15 Aug 2010 15:15:03 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q25sm5725887ybk.18.2010.08.15.15.15.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 15:15:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008152357.29889.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153623>

Jakub Narebski wrote:

> 15. Which of the following features do you use?
>=20
> (multiple choice, with other)

Very nice list!  =E2=80=9Cother=E2=80=9D seems odd --- what would the e=
xpected
response look like?

> 16. Which of the following features would you like to see implemented
>     in git?
[...]
>  + environmental variables in config, expanding ~ and ~user

I think we have ~ and ~user now.

> 17. Describe what features would you like to have in Git,=20
>     if it is not on the list above?
>=20
> (free form, essay length)

Nice.
