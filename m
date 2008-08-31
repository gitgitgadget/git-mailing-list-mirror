From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sun, 31 Aug 2008 12:54:42 -0700
Message-ID: <53906E21-DE02-4C85-8CC0-4E4AC53AE130@develooper.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 21:55:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZt1b-0000tv-As
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 21:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbYHaTyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 15:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbYHaTyq
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 15:54:46 -0400
Received: from x8.develooper.com ([216.52.237.208]:36676 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbYHaTyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 15:54:45 -0400
Received: (qmail 19211 invoked from network); 31 Aug 2008 19:54:43 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 31 Aug 2008 19:54:43 -0000
In-Reply-To: <20080830173947.GF7185@schiele.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94503>


On Aug 30, 2008, at 10:39, Robert Schiele wrote:

> git-add--interactive has one Perl command that was not yet present in
> Perl 5.6.  Changing this single command makes it compatible again.

Perl 5.8.0 was released six years ago.  Perl 5.6.0 was released in  
*2000*.  I think we can safely tell people to get with the program and  
use Perl 5.8.

> This is an alternative to my previous patch that just declared Perl  
> 5.8 to
> be the required version.


+1 to that one.


  - ask

-- 
http://develooper.com/ - http://askask.com/
