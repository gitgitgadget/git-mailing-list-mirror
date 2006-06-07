From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: http-fetch segfault fix?
Date: Wed, 7 Jun 2006 08:32:14 -0700
Message-ID: <20060607153214.GB4000@reactrix.com>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org> <7vodx6zus2.fsf@assigned-by-dhcp.cox.net> <1149610759.27253.9.camel@dv> <20060606164618.GC3938@reactrix.com> <1149619097.25298.6.camel@dv> <7vlks9le8b.fsf_-_@assigned-by-dhcp.cox.net> <1149658914.5648.5.camel@dv> <7vhd2xld77.fsf@assigned-by-dhcp.cox.net> <1149690584.19551.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 17:32:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo01B-0002ti-8y
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 17:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWFGPcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWFGPcW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 11:32:22 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:26733 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932265AbWFGPcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 11:32:21 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k57FWIB9025921;
	Wed, 7 Jun 2006 08:32:18 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k57FWEuT025918;
	Wed, 7 Jun 2006 08:32:14 -0700
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1149690584.19551.2.camel@dv>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21439>

On Wed, Jun 07, 2006 at 10:29:44AM -0400, Pavel Roskin wrote:

> Both git-clone instances (with and without USE_CURL_MULTI) have
> completed successfully on http://www.denx.de/git/linux-2.6-denx.git
> 
> Nick, thank you for fixing this bug!

Whew...  I look forward to working on something other than fixing
segfaults.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
