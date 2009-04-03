From: Miles Bader <miles@gnu.org>
Subject: Re: Whitespace options
Date: Fri, 03 Apr 2009 11:39:33 +0900
Message-ID: <buoab6yjw9m.fsf@dhlpc061.dev.necel.com>
References: <3C72F4A7-9B7A-44D0-B13D-FD534EB02C27@bitart.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerd Knops <gerti-git@bitart.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 04:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpZLt-0004lA-D4
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 04:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbZDCCjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 22:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbZDCCjo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 22:39:44 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:34367 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZDCCjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 22:39:44 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n332dPuB001065;
	Fri, 3 Apr 2009 11:39:34 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Fri, 3 Apr 2009 11:39:34 +0900
Received: from dhlpc061 ([10.114.112.72] [10.114.112.72]) by relay21.aps.necel.com with ESMTP; Fri, 3 Apr 2009 11:39:33 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 84FC452E20F; Fri,  3 Apr 2009 11:39:33 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <3C72F4A7-9B7A-44D0-B13D-FD534EB02C27@bitart.com> (Gerd Knops's
	message of "Thu, 2 Apr 2009 14:18:19 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115512>

Gerd Knops <gerti-git@bitart.com> writes:
> The reason is that many editors (especially those supporting indent-
> based code folding) keep 'empty' lines at the current indentation
> level. git (with default settings) flags all those lines.

That sounds like very fragile behavior on the part of the editor -- it
sounds like they assume that all source code was created by their
editor, and will never be touched by any other tool...

-Miles

-- 
Suburbia: where they tear out the trees and then name streets after them.
