From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Thu, 26 Feb 2009 17:11:37 -0500
Message-ID: <76718490902261411pc8b97wdb43baf02eebe0c3@mail.gmail.com>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com>
	 <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net>
	 <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
	 <49A66057.1050501@drmicha.warpmail.net>
	 <7vfxi1t99u.fsf@gitster.siamese.dyndns.org>
	 <49A6D5E5.8000007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcoTz-0003im-Aw
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 23:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759987AbZBZWLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 17:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759979AbZBZWLl
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 17:11:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:1985 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759972AbZBZWLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 17:11:40 -0500
Received: by rv-out-0506.google.com with SMTP id g37so732377rvb.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5U0NAuKzgeDIwlY5na9dIDQma0wIXYWJ22LXjUuvj08=;
        b=hD32j577bkq6GpXTld9gup94lkz+Q8zCMpIscaoRBox0wDeKY4F4x40qNilz8XzaXS
         cxlvkfIVFqsEEXjkUh8nSTwZgQ7eGVnipjgjKgW69eK3ASvyuytY9fTI59kv6tPsRAHD
         Vp+u42smlupQQ5Kn4A/jVKj6fLNMIV9qqOMOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LPkKWmkNi3+UUToL3TKbeRC353h7cS4cFi31BYtWIqSbkPxllC4tgOkv6u7GF86W+x
         q6eKsH/Kc0/U/pADTxAJ/E5V83GF+e5Cu7JpY156GmaSAULR41DjO7sSCHAVrw/cAto3
         Yw2DVly8mNp7YcnXgGifq6+uIBtcvPXaksmj8=
Received: by 10.141.180.16 with SMTP id h16mr826624rvp.295.1235686297788; Thu, 
	26 Feb 2009 14:11:37 -0800 (PST)
In-Reply-To: <49A6D5E5.8000007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111603>

On Thu, Feb 26, 2009 at 12:48 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> Of course. I ursurpated someone else's itch here, but now it's mine ;)

Well then, I owe you one. In the mean time, thank you. :-)

j.
