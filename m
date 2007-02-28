From: Simon Josefsson <simon@josefsson.org>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Wed, 28 Feb 2007 15:27:05 +0100
Message-ID: <87zm6y5pdy.fsf@latte.josefsson.org>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<200702271257.37437.andyparkins@gmail.com>
	<200702272227.05244.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.63.0702272227500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 15:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMPmw-00012l-2E
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 15:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbXB1O1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 09:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbXB1O1h
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 09:27:37 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:58284
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbXB1O1g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 09:27:36 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l1SER7Oh029866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Feb 2007 15:27:07 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070228:andyparkins@gmail.com::jaFT7hbjJE3DfNMZ:15kT
X-Hashcash: 1:22:070228:robin.rosenberg.lists@dewire.com::EXRFrVpVgo4GHXCp:0oEc
X-Hashcash: 1:22:070228:git@vger.kernel.org::19nT8xF6aVJOfWS6:EZVp
X-Hashcash: 1:22:070228:johannes.schindelin@gmx.de::9kd+E+Z5+7C5NIDS:CnqM
In-Reply-To: <Pine.LNX.4.63.0702272227500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue\, 27 Feb 2007 23\:12\:39 +0100
	\(CET\)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-2.0 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40926>

FYI, the GNU ChangeLog format is actually documented, see:

http://www.gnu.org/prep/standards/html_node/Change-Logs.html

And some parts of it (function names, CPP macro conditionals) are
quite neat, although I'm not sure how much of it can be automatically
generated, or if that is even something you'd want.

/Simon
