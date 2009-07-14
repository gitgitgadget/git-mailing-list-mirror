From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: [commit 4ecbc178704] Incosistency?
Date: Tue, 14 Jul 2009 23:42:12 +0100
Message-ID: <18071eea0907141542g46d9deb2k1647cabc998e61ea@mail.gmail.com>
References: <Pine.LNX.4.64.0907142335210.31779@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Unknown <borg@uu3.net>
X-From: git-owner@vger.kernel.org Wed Jul 15 00:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQqhv-0000pT-OP
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 00:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635AbZGNWmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 18:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbZGNWmf
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 18:42:35 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:65121 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbZGNWme convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 18:42:34 -0400
Received: by fxm18 with SMTP id 18so3116404fxm.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JHfDRzrg2rFe8dOj+5de8UgvuKa4jL4KkOl8l+gK8qI=;
        b=ZTIsNeXxbOpKOwT4RjabR6zyaog/T8T3j5qfVgXg225oNrCvZfhDCkeKy/AKZMB0EL
         JJxSLOqyjZK+UdcMJODeMgPvKnQuaV0ZldDkYNJV2Og0esRS/Jq1UBoTKextFRNqvFRI
         Y2i2EORb3dGZ3aDNSNsulgq4z2mlanfU7n5/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AYBxD9BHQglh923xQjje/HllUK5YLvIvx+13VA4RsmfgZJ1Mcfq2+jLDJinsfvU6ZJ
         qKemW+ZR+195wAYADqb5LUCAbdf/sLSJPANuIws24AwPvfA3Cy3JOLj1tx+7Cq76otCX
         KodyCGsl9t3PLZ4SoePGe/x/NGEE8wuPJGNxI=
Received: by 10.204.64.145 with SMTP id e17mr6876852bki.129.1247611352293; 
	Tue, 14 Jul 2009 15:42:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0907142335210.31779@cube>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123275>

Dear me --

2009/7/14 Unknown <borg@uu3.net>:
> commit 4ecbc178704ca6c1027a38483e98f5fe493b1322
> Author: Jeff King <peff@peff.net>
> Date: =A0 Thu Jul 9 02:37:35 2009 -0400
>
> bla bla.. some strange SUDO fix (who the hell uses git that way?)
> I dont like it.. git-add in libexecdir was good!

No, your understanding of that stinks.  The test, *without* your
so-called patch wotk just fine.

-- Thomas Adam
