From: Pascal Obry <pascal@obry.net>
Subject: Re: What's cooking in git.git (Oct 2011, #01; Tue, 4)
Date: Thu, 06 Oct 2011 16:50:02 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E8DC01A.8060406@obry.net>
References: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBpIo-0002vn-JY
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 16:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992Ab1JFOuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 10:50:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61316 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964988Ab1JFOuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 10:50:11 -0400
Received: by ywb5 with SMTP id 5so2654586ywb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 07:50:10 -0700 (PDT)
Received: by 10.236.128.231 with SMTP id f67mr230689yhi.56.1317912610787;
        Thu, 06 Oct 2011 07:50:10 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-64-191.w83-199.abo.wanadoo.fr. [83.199.102.191])
        by mx.google.com with ESMTPS id x65sm7856119yhg.18.2011.10.06.07.50.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 07:50:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182958>

Le 05/10/2011 04:12, Junio C Hamano a =E9crit :
> --------------------------------------------------
> [Stalled]

> * po/cygwin-backslash (2011-08-05) 2 commits
>   - On Cygwin support both UNIX and DOS style path-names
>   - git-compat-util: add generic find_last_dir_sep that respects is_d=
ir_sep
>
> Incomplete with respect to backslash processing in prefix_filename(),=
 and
> also loses the ability to escape glob specials.
> Will discard.

Sorry but this is letting best be enemy of good! But frankly I've lost=20
all interest at making Cygwin/Git behave better.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
