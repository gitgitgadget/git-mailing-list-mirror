From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: Re: [PATCH] Invoke "git gc --auto" when a commit is successful.
Date: Sat, 21 Mar 2009 16:37:19 -0700
Message-ID: <49C57A2F.6010709@whistlingcat.com>
References: <1237674894-8151-1-git-send-email-dmellor@whistlingcat.com> <7viqm2bgou.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAmB-0002oK-Ke
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbZCUXhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbZCUXhW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:37:22 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:51488 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbZCUXhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:37:22 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id EE9D03823E;
	Sat, 21 Mar 2009 16:37:19 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id BBD4238E755B;
	Sat, 21 Mar 2009 16:37:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7viqm2bgou.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114098>

On 03/21/2009 04:26 PM, Junio C Hamano wrote:
> I do not think situation has changed since the previous round:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/78524/focus=82130
> 
> 
Thanks for the pointer. I had searched the list before coding this up, 
but somehow had missed this thread.
