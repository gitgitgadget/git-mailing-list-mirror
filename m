From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Wed, 7 Feb 2007 18:24:28 -0600
Message-ID: <17866.28092.167065.520654@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.63.0702080121240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:24:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEx5d-0000lh-7G
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161485AbXBHAYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933344AbXBHAYg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:24:36 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60110 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933347AbXBHAYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:24:35 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l180OVt15244;
	Wed, 7 Feb 2007 18:24:31 -0600
In-Reply-To: <Pine.LNX.4.63.0702080121240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39017>

On Thursday, February 8, 2007 at 01:22:24 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Wed, 7 Feb 2007, Bill Lear wrote:
>
>> So, 1) how do I get back to the status quo ante?  I have about 30 files 
>> listed as "Updated but not checked in", then this:
>
>git reset --hard
>
>It's probably explained in the new user manual (I did not check).

Hmm ... from my topic branch:

% git reset -hard
Usage: /usr/bin/git-reset [--mixed | --soft | --hard]  [<commit-ish>]


Bill
