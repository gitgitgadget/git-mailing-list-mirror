From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Sun, 11 Nov 2007 23:57:52 -0800
Message-ID: <F88B2A1B-94E6-4577-BFB8-C3985D35FD55@develooper.com>
References: <20071111235819.GB7392@thunk.org> <1194829077-14320-1-git-send-email-tytso@mit.edu> <7vzlxk8apz.fsf@gitster.siamese.dyndns.org> <20071112062222.GA17462@thunk.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 12 08:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrUBP-0001L9-1Q
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 08:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbXKLH5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 02:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbXKLH5z
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 02:57:55 -0500
Received: from x8.develooper.com ([216.52.237.208]:50651 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbXKLH5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 02:57:54 -0500
Received: (qmail 15055 invoked from network); 12 Nov 2007 07:57:53 -0000
Received: from gw.develooper.com (HELO g5.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 12 Nov 2007 07:57:53 -0000
In-Reply-To: <20071112062222.GA17462@thunk.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64571>


On Nov 11, 2007, at 10:22 PM, Theodore Tso wrote:

> They probably would be submitting changes back upstream using e-mail
> before they learn how to publish their own repository, so commands I'd
> be tempted to add would include git-format-patch, git-send-email, and
> git-cherry.  But these commands are pretty complicated for  
> beginners....

Maybe split it into sections?   I'm all for making it appear simpler,  
but not for hiding the power features of git too much.  :-)

"These are basic local commands"

"This is what you need to interact with a remote repository"

"This is what you need for branching and merging"

"This is what you need to make, manage and apply patches"


  - ask

-- 
http://develooper.com/ - http://askask.com/
