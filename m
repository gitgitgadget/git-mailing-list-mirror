From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Sun, 24 Aug 2008 10:40:00 +0200
Message-ID: <48B11E60.1020506@s5r6.in-berlin.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 10:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXBAX-0001xl-76
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 10:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYHXIkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 04:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYHXIkl
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 04:40:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41282 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYHXIkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 04:40:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m7O8e6K8014819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 24 Aug 2008 10:40:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080722 SeaMonkey/1.1.11
In-Reply-To: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93522>

Junio C Hamano wrote:
> People seems to have quite strong negative feelings on the removal of
> dashed form "git-foo" commands from their $PATH.

Some of them may appreciate git-completion.bash.  On my box I found it 
named /usr/share/bash-completion/git.
-- 
Stefan Richter
-=====-==--- =--- ==---
http://arcgraph.de/sr/
