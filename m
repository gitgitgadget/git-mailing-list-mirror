From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: gitk patch collection pull request
Date: Sat, 20 Oct 2007 14:00:20 +0100
Message-ID: <B3349B61-995B-42D0-B777-CEA618943848@steelskies.com>
References: <20071019052823.GI14735@spearce.org> <18200.36704.936554.220173@cargo.ozlabs.ibm.com> <531A500E-667F-413C-BD20-D23DC817EB72@steelskies.com> <18201.60047.898077.579869@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjDwS-0006IE-BC
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbXJTNAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbXJTNAY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:00:24 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:39154 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbXJTNAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 09:00:23 -0400
Received: from takwin.config (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id D02BF9803D;
	Sat, 20 Oct 2007 14:00:21 +0100 (BST)
In-Reply-To: <18201.60047.898077.579869@cargo.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61829>


On 20 Oct 2007, at 12:46, Paul Mackerras wrote:

> Jonathan del Strother writes:
>
>> In my defense, most of that file is space indented, and the places
>
> Only the lines that are indented 1 level start with spaces.  Any line
> that is indented 2 or more levels should start with a tab.

>> It seems to have the whole 'tabs for code
>> indentation, with space for alignment' rule back-to-front.
>
> I don't recall signing up to that rule. :)  I use 4-column indentation
> and 8-column tabs, and my editor (emacs) handles it all automatically
> for me.


Ugh...  I don't usually get involved in tab/space wars, but I'm  
curious... why on earth would you choose this style?
With space indentation you can make sure that everyone sees the  
indentation as it was intended.  With tab indentation, you save space,  
add semantic meaning, and let people control how wide they want their  
indents to appear.  This approach seems to take the worst parts of  
each and combine them.  What's the benefit?

I appreciate I'm not going to convert you - this is an honest question.
