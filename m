From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: Deprecate git-fetch-pack?
Date: Sat, 10 Nov 2007 19:09:28 -0800
Message-ID: <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 04:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir3JI-0007PU-2m
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 04:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbXKKDQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 22:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbXKKDQL
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 22:16:11 -0500
Received: from x8.develooper.com ([216.52.237.208]:44892 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbXKKDQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 22:16:11 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2007 22:16:10 EST
Received: (qmail 30328 invoked from network); 11 Nov 2007 03:09:29 -0000
Received: from gw.develooper.com (HELO g5.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 11 Nov 2007 03:09:29 -0000
In-Reply-To: <7v4pftip42.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64393>


On Nov 10, 2007, at 4:48 PM, Junio C Hamano wrote:

> As to peek-remote, ls-remote over the native transport is a
> synonym so I do not think anybody doing the scripting would have
> problem doing s/peek-/ls-/ to their script, but again I do not
> see a heavy maintenance burden to keep the synonym, yet.

For new users the superfluous programs are a burden making it harder  
to learn how everything works.

"What does this thing do?  How is it different from that other similar  
program?  How do they interact?  Oh, this one isn't really used.  Grrh."

At least a note in the documentation that it's superseded by  
$other_program would be helpful for us newcomers.  :-)


  - ask

-- 
http://develooper.com/ - http://askask.com/
