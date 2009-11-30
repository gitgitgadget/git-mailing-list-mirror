From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 16:31:44 +0100
Message-ID: <hf0oh0$elj$1@ger.gmane.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 16:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF8Eb-0001yW-FV
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 16:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZK3PcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 10:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZK3PcE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 10:32:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:38062 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbZK3PcD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 10:32:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NF8ES-0001vD-5y
	for git@vger.kernel.org; Mon, 30 Nov 2009 16:32:08 +0100
Received: from 93-34-210-248.ip51.fastwebnet.it ([93.34.210.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 16:32:08 +0100
Received: from bonzini by 93-34-210-248.ip51.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 16:32:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93-34-210-248.ip51.fastwebnet.it
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-3.9.b4.fc12 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134112>

On 11/30/2009 03:43 PM, Bernhard R. Link wrote:
> The itch this idea is supposed to scratch is the problem that a rebase
> or a amended commit is no longer a fast-forward, so cannot be easily
> pulled.

How does this compare with topgit?

Paolo
