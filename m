From: Ximin Luo <xl269@cam.ac.uk>
Subject: Re: [git-svn] [BUG] merge-tracking inconsistencies; Was: [FEATURE-REQ]
 track merges from git
Date: Wed, 26 Aug 2009 21:55:06 +0100
Message-ID: <4A95A12A.3060403@cam.ac.uk>
References: <4A9565ED.4010608@cam.ac.uk> <3e8340490908261206xc4156c4mb46e4c7de264df11@mail.gmail.com> <4A95A032.3000801@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 22:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgPVG-0004gE-9F
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 22:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZHZUxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 16:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbZHZUxp
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 16:53:45 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:43443 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZHZUxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 16:53:45 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from 94-192-233-202.zone6.bethere.co.uk ([94.192.233.202]:64808 helo=[192.168.1.64])
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:587)
	with esmtpsa (PLAIN:xl269) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1MgPV5-0001e1-0C (Exim 4.70)
	(return-path <xl269@cam.ac.uk>); Wed, 26 Aug 2009 21:53:47 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4A95A032.3000801@cam.ac.uk>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127117>

Ximin Luo wrote:
> the tip of trunk is NOT a tip of test1

er, that should read "the tip of trunk is NOT a parent of the tip of test1"

X
