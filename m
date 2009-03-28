From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git Download/Bootstrap Suggestion
Date: Sat, 28 Mar 2009 17:15:51 +0100
Message-ID: <fabb9a1e0903280915l512374ebt8a1f804666dfe87b@mail.gmail.com>
References: <49CD0841.9000602@gmail.com> <fabb9a1e0903271621g392eefdeu85b46c655c1ad067@mail.gmail.com> 
	<49CE4BD2.4060808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 28 17:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnbE4-000887-Ot
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 17:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbZC1QQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbZC1QQK
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 12:16:10 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:48182 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbZC1QQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 12:16:09 -0400
Received: by bwz17 with SMTP id 17so1366135bwz.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W5sWxcIGdw5Iq9wiOeXqCzq2UxDIwaD941Ejh3SBV+g=;
        b=HbRDabO8upg2Fq/KM6wo3n8Wtua1MUxbNcb56X61vurgffp+f/limwRjAC69dXChTZ
         zRIndF07Yb6FMwhvwDIUelP+iTmDyIelJmHE8SwAyxTXviyl6shf71e324pol2E08a3p
         sf4QJlPiEya+kk7OgQnhAbLBsFFGom7aFbMn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PdXoGRbnXWhtmcR4+mscw4IRKfz5Zt6VNdkCnZylsoMEYXeL1HGomfNTGyz4Z1W7Ft
         SHqEyUJisBjaANgG0iskD9e5YWFobpAQpxUJozInlTOzm3LM3PUr+opmpdX4JXumEyoI
         PiAgj1WMVDMy/wG2IXxTCixelRq9H7zU5aWGY=
In-Reply-To: <49CE4BD2.4060808@drmicha.warpmail.net>
Received: by 10.103.248.17 with SMTP id a17mr884540mus.83.1238256966236; Sat, 
	28 Mar 2009 09:16:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114965>

Heya,

On Sat, Mar 28, 2009 at 17:09, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> No, I think he meant repo, not work tree.

Why would he need the repo to bootstrap?

-- 
Cheers,

Sverre Rabbelier
