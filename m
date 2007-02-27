From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Tue, 27 Feb 2007 15:22:54 -0800
Message-ID: <7vodnfb2y9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<alpine.LRH.0.82.0702271036010.29426@xanadu.home>
	<Pine.LNX.4.63.0702271656540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070227231100.GA25782@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>, junkio@cox.net
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBh4-0006Fs-SD
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbXB0XYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXB0XYI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:24:08 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36169 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbXB0XW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:22:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227232255.VFHM3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 18:22:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UnNu1W00x1kojtg0000000; Tue, 27 Feb 2007 18:22:55 -0500
In-Reply-To: <20070227231100.GA25782@localdomain> (Eric Wong's message of
	"Tue, 27 Feb 2007 15:11:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40843>

Eric Wong <normalperson@yhbt.net> writes:

> --pretty=gnu sounds nice, however :)

Huh?  It has the same problem as the earlier one suggested by
HPA: --pretty=rpm ;-)
