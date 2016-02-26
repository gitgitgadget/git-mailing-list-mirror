From: Kevin Daudt <me@ikke.info>
Subject: Re: Restore Question
Date: Fri, 26 Feb 2016 17:44:06 +0100
Message-ID: <20160226164406.GA19120@ikke.info>
References: <loom.20160226T151716-809@post.gmane.org>
Reply-To: git@lists.ikke.info
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerald <gmckinley@ventureforth.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 17:44:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLUz-0003VG-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbcBZQoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:44:09 -0500
Received: from ikke.info ([178.21.113.177]:39987 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981AbcBZQoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 11:44:08 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 72143440082; Fri, 26 Feb 2016 17:44:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <loom.20160226T151716-809@post.gmane.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287589>

On Fri, Feb 26, 2016 at 02:18:16PM +0000, Gerald wrote:
> I have git running on a VMware virtual machine.  I backup the virtual
> machine every day.  How do I restore git from a restore of the virtual machine?
> 

Can you explain what you mean exactly with restoring git? It's unclear
what you want to achieve.

Retrieving a git repository is just a matter of copying the entiry
repository directory (including .git dir).
