From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Araxis in mergetool, was Re: What's cooking in git.git (May 2009, #03; Mon, 25)
Date: Mon, 25 May 2009 15:23:52 -0700
Message-ID: <7viqjovn2f.fsf@alter.siamese.dyndns.org>
References: <7vd49xy42b.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0905251050050.4288@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 26 00:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iaO-0000Mp-Tf
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZEYWXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbZEYWXw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:23:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61724 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbZEYWXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:23:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525222353.FOJC18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 May 2009 18:23:53 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id vyPt1b0024aMwMQ04yPtii; Mon, 25 May 2009 18:23:53 -0400
X-Authority-Analysis: v=1.0 c=1 a=-5M0XOanfNQA:10 a=IOLOfgZi2YMA:10
 a=gCa3sRjYjuRCV74dxVYA:9 a=SPCg1Md6_lhXpyvKHU2FAidsOiwA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119972>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 25 May 2009, Junio C Hamano wrote:
>
>> * da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
>>  + mergetool--lib: add support for araxis merge
>> 
>> I admit that I feel certain distaste in supporting a closed tool, but we
>> already make things bearable for people on Windows; Araxis is no worse,
>> right?
>
> Well, I think it is the first closed-source tool that we support,...

I do not think Windows and/or MacOSX were open-source tools ;-)
