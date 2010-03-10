From: tytso@mit.edu
Subject: Re: Modified files directly after clone
Date: Wed, 10 Mar 2010 08:48:36 -0500
Message-ID: <20100310134836.GJ13487@thunk.org>
References: <7416BCB6-306F-4BC1-913C-1208746DA93E@ee.ethz.ch>
 <905315641003091359q4f7cd533o698ec507b9805e36@mail.gmail.com>
 <18121BB2-A8BE-411F-9CF0-EDDD12B31CB3@ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org
To: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 10 14:48:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpMHF-0003OL-NI
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 14:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247Ab0CJNsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 08:48:40 -0500
Received: from THUNK.ORG ([69.25.196.29]:55474 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152Ab0CJNsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 08:48:39 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1NpMH7-000840-6D; Wed, 10 Mar 2010 08:48:37 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1NpMH6-0000If-G1; Wed, 10 Mar 2010 08:48:36 -0500
Content-Disposition: inline
In-Reply-To: <18121BB2-A8BE-411F-9CF0-EDDD12B31CB3@ee.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141888>

On Wed, Mar 10, 2010 at 07:47:24AM +0100, Benedikt Andreas Koeppel wrote:
> Hello,
> 
> Am 09.03.2010 um 22:59 schrieb Tarmigan:
> > By default HFS+ filesystems on OSX are case insensitive so you see
> > problems like you described with the linux kernel source which has
> > different files named xt_TCPMSS.c and xt_tcpmss.c.
> 
> thank you very much for the explanation. Unfortunately, some
> software (namely Adobe CS2) does not work properly with HFS+ with
> case sensitivity. I'll need to get a Linux PC for coding :-).

Or you could get a firewire hard drive that you format with HFS+ case
sensensitivity enabled, and connect it up to your Mac machine; but
don't let me stop you from getting a Linux PC for coding.  :-)

      	     	      	   	   - Ted
