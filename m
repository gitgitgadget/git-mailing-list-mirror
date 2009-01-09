From: David Brown <git@davidb.org>
Subject: Re: Curious about details of optimization of object database...
Date: Fri, 9 Jan 2009 09:56:19 -0800
Message-ID: <20090109175619.GA807@linode.davidb.org>
References: <20090109174623.GC12552@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Fri Jan 09 18:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLLcI-0007yH-Tz
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 18:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbZAIR4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 12:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbZAIR4V
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 12:56:21 -0500
Received: from linode.davidb.org ([72.14.176.16]:44766 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbZAIR4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 12:56:20 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1LLLal-0000Fu-E6; Fri, 09 Jan 2009 09:56:19 -0800
Content-Disposition: inline
In-Reply-To: <20090109174623.GC12552@seberino.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105023>

On Fri, Jan 09, 2009 at 09:46:23AM -0800, chris@seberino.org wrote:
>I'm told a commit is *not* a patch (diff), but, rather a copy of the entire
>tree.
>
>Can anyone say, in a few sentences, how git avoids needing to keep multiple
>slightly different copies of entire files without just storing lots of
>patches/diffs?

   Documentation/technical/pack-heuristics.txt

David
