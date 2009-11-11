From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Wed, 11 Nov 2009 09:11:20 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AFA71A8.8020100@obry.net>
References: <4AF9E7FE.3060701@obry.net> <4AFA3751.7000709@vilain.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88IN-0003hq-87
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827AbZKKILD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756661AbZKKILC
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:11:02 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:62760 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbZKKILB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:11:01 -0500
Received: by ewy3 with SMTP id 3so889552ewy.37
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 00:11:06 -0800 (PST)
Received: by 10.213.1.5 with SMTP id 5mr6179826ebd.71.1257927066103;
        Wed, 11 Nov 2009 00:11:06 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 23sm3542694eya.4.2009.11.11.00.11.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 00:11:04 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <4AFA3751.7000709@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132618>

Sam,

> Did you copy the entire directory across using rsync/tar/etc or 'git
> clone' ?

I did a rsync of the .git directory so I expect all refs to be there.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
