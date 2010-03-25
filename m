From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 16:26:20 -0300
Message-ID: <4BABB8DC.7060906@gmail.com>
References: <4BAADF34.3080806@gmail.com> <4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu> <4BAAE981.4040205@gmail.com> <alpine.LFD.2.00.1003251459540.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@MIT.EDU>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Mar 25 20:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NushO-0007OR-JC
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 20:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab0CYT03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 15:26:29 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34546 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab0CYT02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 15:26:28 -0400
Received: by fxm5 with SMTP id 5so1353211fxm.29
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=JXyBaCucpwteCstVyiRwk121GE9WwzNI7butcKZbmtA=;
        b=FXBuLSYwf6zSNMiz6gbEoNURIDcsSJk3g4AccjeDT1CD+6TXwDeDrt2T5HhpLs/TmX
         oDVZh5kNyfgC9oKmiIvwQhj2x+tmiFNNFT6pF/Zn65aFNBt8DHH7o8shmN5MfX27MOTL
         ZOeh8gmjNSPnynk61kfsq4RW1tQd5z6w82u2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=DQBC/pQcgtToA2rrDoe6qXtxQB7BXlCX3DzFboprzgqUNgC5Xgvv0J/+YAslFfVO5r
         2Z7k52dsTU42/GnVUxD6vrEYoJuPyASC/hqiMgwYgXYaWQDa0VHLOk/PvrWoV5r2rm5I
         uVQ5+4kUJrlYnHSwe1bbvWF48Xwkm/zABWXK8=
Received: by 10.102.181.25 with SMTP id d25mr14706831muf.38.1269545186409;
        Thu, 25 Mar 2010 12:26:26 -0700 (PDT)
Received: from [129.173.97.249] (D61F9.WPA.Dal.Ca [129.173.97.249])
        by mx.google.com with ESMTPS id i7sm175460mue.4.2010.03.25.12.26.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 12:26:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
In-Reply-To: <alpine.LFD.2.00.1003251459540.694@xanadu.home>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143193>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In the end, I managed to convince them they wouldn't be spammed (hope
I'm right), and I used their real emails. Nonetheless, I appreciate the
help.

If you're still in the helping mood (and know what you're talking
about), I'm still looking for help with a case where an SVN repo is
split into separate git repositories & being unable to dcommit changes
back to SVN. The archived email is:
http://article.gmane.org/gmane.comp.version-control.git/142654

Thanks,
- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuruNwACgkQst0AR/DaKHsN/QCg2wyWwps6FEibNlBI5hlf9Fwd
ODcAoKkcjpxNkPrVxlT690F2znoAUzlU
=rkB8
-----END PGP SIGNATURE-----
