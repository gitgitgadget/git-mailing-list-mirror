From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 15:58:41 +0100
Organization: Home - http://www.obry.net
Message-ID: <49087A21.1080508@obry.net>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:00:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvCWl-0001Yr-CX
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbYJ2O6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbYJ2O6x
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 10:58:53 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:14358 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYJ2O6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 10:58:52 -0400
Received: by ik-out-1112.google.com with SMTP id c29so32534ika.5
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 07:58:49 -0700 (PDT)
Received: by 10.86.76.16 with SMTP id y16mr5810754fga.17.1225292329419;
        Wed, 29 Oct 2008 07:58:49 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-40-132.w82-124.abo.wanadoo.fr [82.124.144.132])
        by mx.google.com with ESMTPS id 4sm156106fge.8.2008.10.29.07.58.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 07:58:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.17) Gecko/20080914 Thunderbird/2.0.0.17 Mnenhy/0.7.5.0
In-Reply-To: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99367>

What about :

   $ git config --global alias.staged "diff --cached"

I'm using this since some time.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
