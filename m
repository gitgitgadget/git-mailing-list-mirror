From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/11] user-manual.txt: explain better the
 remote(-tracking) branch terms
Date: Sat, 30 Oct 2010 02:18:11 -0500
Message-ID: <20101030071811.GA30779@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288411819-24462-10-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 30 09:18:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC5iE-0000Oy-Iw
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 09:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab0J3HSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 03:18:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:32836 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0J3HSW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 03:18:22 -0400
Received: by gxk23 with SMTP id 23so2406867gxk.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2f5AhF+HXmqDB9J7EIUab9XnmBbus0bAkEMDkMfraV8=;
        b=c/jnI36IfBO+BfsWjZB09TMCWTTBKboLp1zFyiAVQ5A3KxyO0mJhcZ2J6CEO/eKbyB
         k5t4bPcUTkSZd2v18m3MXPrlwksIJ8exsOP5ls1ttwNQcW+AYaY19U0XoNBLuQ39kzzR
         PXKz8Y1n7sKpXc8k3q1iN0ehUZ3LKYmBRRCD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pGBgBeLRTJFE08rLjhqGh1lcgmwCiWXHTClFXUZSJUTu3H6qaO6XPh2M6xeOCpKnQn
         c10MnsDEtrg3l6kSPcVoXIBCG6SBtphiNBQXY4Bthg+WFja+msOkD4C72LWhYsDKJv7c
         FhHD9gTohk7DLn/0qLFLCaghms2GwZNReeYoI=
Received: by 10.151.100.20 with SMTP id c20mr19351158ybm.227.1288423099933;
        Sat, 30 Oct 2010 00:18:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n28sm2546764yha.16.2010.10.30.00.18.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 00:18:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288411819-24462-10-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160391>

Matthieu Moy wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -359,6 +360,14 @@ $ git branch -r
>    origin/todo
>  ------------------------------------------------
>  
> +In this case, "origin" is called a remote repository, or "remote" for
[...]

Did you send the wrong patch?  This looks the same as last time.

(comparing to
<http://thread.gmane.org/gmane.comp.version-control.git/159798/focus=160252>)
