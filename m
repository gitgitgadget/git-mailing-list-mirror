From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 2/4] completion: Use consistent if [...] convention. No
 test.
Date: Wed, 11 Feb 2009 13:43:11 -0500
Message-ID: <49931C3F.4000903@tedpavlic.com>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com> <1234375406-27099-2-git-send-email-ted@tedpavlic.com> <1234375406-27099-3-git-send-email-ted@tedpavlic.com> <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK4q-0006bu-30
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624AbZBKSnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbZBKSnV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:43:21 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:50541 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756303AbZBKSnU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:43:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 9F2B780D8089;
	Wed, 11 Feb 2009 13:36:49 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MsXvdUQF1803; Wed, 11 Feb 2009 13:36:49 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 54BA080D8088;
	Wed, 11 Feb 2009 13:36:49 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7v63jgg7st.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109497>

> What's with this funny indentation?

In Vim, I have "exapndtabs" set by default. I manually turned it off, 
but during testing, I must have closed Vim and re-opened and forgot to 
turn it back off.

Some time ago, I suggested adding a vim modeline to the file to handle 
turning expandtabs off for everyone who edits it with vim. That change 
got denied.

If you'd like, I can clean up the whitespace and resubmit with Shawn's Acks.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
