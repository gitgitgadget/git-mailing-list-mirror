From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Tue, 20 Nov 2007 01:36:20 -0800
Message-ID: <7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
References: <1195470026-7389-1-git-send-email-ask@develooper.com> <7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 10:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuPX5-0007ip-Ld
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 10:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659AbXKTJgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 04:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755500AbXKTJgW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 04:36:22 -0500
Received: from x8.develooper.com ([216.52.237.208]:51463 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbXKTJgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 04:36:21 -0500
Received: (qmail 27096 invoked from network); 20 Nov 2007 09:36:21 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 20 Nov 2007 09:36:21 -0000
In-Reply-To: <7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65535>


On Nov 19, 2007, at 23:52, Junio C Hamano wrote:

> How did you prepare and send this patch?

git format-patch + tweak in emacs.

> I see 7 preimage lines and 11 postimage lines, although the hunk
> header claims otherwise.
>
> Did you edit the patch in Emacs diff mode or something?

Indeed!  I take it you've seen that particular way of botching it  
before.  :-)

When I was about to send the patch I realized I had added whitespace  
at the end of one of the lines.  Ironically then I ended up just  
sending the messed up patch because I couldn't apply it to my working  
copy after doing a reset.  Being a new git user I convinced myself  
that I had messed up the reset rather than the patch.  Doh.  My  
apologies!   A new patch should be on the list momentarily.


  - ask

-- 
http://develooper.com/ - http://askask.com/
