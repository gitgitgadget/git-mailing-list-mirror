From: Max Kirillov <max@max630.net>
Subject: Re: Recording the current branch on each commit?
Date: Wed, 30 Apr 2014 07:04:37 +0300
Message-ID: <20140430040437.GA5817@wheezy.local>
References: <20140427233635.96eec638b311907e2368f42b42021fd8.fa0e4193ea.wbe@email02.secureserver.net>
 <xmqq1twhs4lt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 06:04:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfLlQ-0001ql-8n
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 06:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbaD3EEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 00:04:49 -0400
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:37220
	"EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101AbaD3EEp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Apr 2014 00:04:45 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-08.prod.phx3.secureserver.net with 
	id w44b1n00S3gsSd60144jRF; Tue, 29 Apr 2014 21:04:44 -0700
Content-Disposition: inline
In-Reply-To: <xmqq1twhs4lt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247673>

On Mon, Apr 28, 2014 at 11:15:10AM -0700, Junio C Hamano wrote:
> "Any additional information about the commit can be added" you
> suggest is exactly the kind of thing we want to avoid, which made
> Linus say in an even older discussion [*2*]:
> 
>     No "this random field could be used this random way" crud,
>     please.

I see, thanks for explanation.

-- 
Max
