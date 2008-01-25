From: Paul Collins <paul@burly.ondioline.org>
Subject: Re: btrfs and git-reflog
Date: Fri, 25 Jan 2008 22:50:32 +1300
Message-ID: <87tzl2b5ef.fsf@burly.wgtn.ondioline.org>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: btrfs-devel@oss.oracle.com
X-From: git-owner@vger.kernel.org Fri Jan 25 10:54:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JILGk-0000pX-Uw
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 10:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbYAYJyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 04:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbYAYJyM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 04:54:12 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:57752 "EHLO
	jenny.ondioline.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYAYJyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 04:54:11 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id 1BD2E3A17A9; Fri, 25 Jan 2008 22:54:10 +1300 (NZDT)
Received: by burly.wgtn.ondioline.org (Postfix, from userid 1000)
	id B0AEE3B179; Fri, 25 Jan 2008 22:50:32 +1300 (NZDT)
In-Reply-To: <873asmcodd.fsf@burly.wgtn.ondioline.org> (Paul Collins's message
	of "Fri, 25 Jan 2008 21:15:26 +1300")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71694>

Correction.

Paul Collins <paul@burly.ondioline.org> writes:

> and then attempt to expire the reflogs
>
>   $ git-reflog --expire --all

  $ git-reflog expire --all

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
