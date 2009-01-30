From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitk run from subdir and "find commit touching paths"
Date: Fri, 30 Jan 2009 13:39:59 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngo60pf.l0k.sitaramc@sitaramc.homelinux.net>
References: <slrngnug78.877.sitaramc@sitaramc.homelinux.net>
 <1c5969370901292156k2456b585r8e79889db516bc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 14:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStcu-0006EP-8s
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbZA3NkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbZA3NkT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:40:19 -0500
Received: from main.gmane.org ([80.91.229.2]:33200 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201AbZA3NkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:40:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LStbR-0003vg-NT
	for git@vger.kernel.org; Fri, 30 Jan 2009 13:40:13 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 13:40:13 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 13:40:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107817>

On 2009-01-30, Matt Graham <mdg149@gmail.com> wrote:
> On Tue, Jan 27, 2009 at 12:14, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> I get this too.  My repos are small enough that I'm usually able to
> just cd to the root dir and rerun gitk.

Mine are too; and if they weren't I'd alias it in bash, no
sweat.  It was just a question to see if it was a known
problem, and really all I wanted was to confirm what I am
seeing.

I'm not even saying it needs to be fixed :-)
