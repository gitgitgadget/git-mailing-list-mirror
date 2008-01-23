From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 14:47:48 +1300
Message-ID: <46a038f90801221747m53975f39y7e2f6b48c5a7f6aa@mail.gmail.com>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org>
	 <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
	 <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
	 <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	 <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	 <E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 02:48:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHUiz-0006i0-AZ
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 02:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbYAWBrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 20:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYAWBrv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 20:47:51 -0500
Received: from hu-out-0506.google.com ([72.14.214.230]:10097 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbYAWBru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 20:47:50 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1124685hue.21
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 17:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FB+sS5f2WxCpNQ23zkLBTas1O/BREdBuElam3H0xA4c=;
        b=KaifmefUM9a7ScL3ZhqnoZXhOrte2kXlBTdr8rhM0M8eBqupEb9/hMQ9eYgd4QPJtyBCDR9KKFn88R611sQpYLVe/cCbxr859rq9w3rk0TMul+j0b1XRsx0xq6WFecnwDgo6lUcrHye6aKXvVNE+qqDfeYX5JXRDiIHThCNQ5r8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vrwAjV6gAuNrGhI9mI52mDbqyJHMq6tXcl7FaRdVJhO8fRJK8nchyVKHQ/Y/6747BjZ1FPLB3bowq0yiWRML0enbP9nYeURguEu/UN2YB5X/JN4FmunrHgtfXkZwBJkEY4TsTwZ3+ec0IyG8rkhXIIzw4xJO8J/1pbOw+PtOxF0=
Received: by 10.67.116.7 with SMTP id t7mr316875ugm.38.1201052868514;
        Tue, 22 Jan 2008 17:47:48 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 22 Jan 2008 17:47:48 -0800 (PST)
In-Reply-To: <E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71488>

On Jan 23, 2008 1:38 PM, Kevin Ballard <kevin@sb.org> wrote:
> I must say it is shocking

Don't ruin it. You were silent for 12hs and lots of patches and
research on the problem started flowing. If you keep making a nuisance
of yourself, people will turn from helping you to beating you up for
being so annoying.

Perhaps help prepare those tests you said it was a good idea to work
on. If you manage to stay silent a bit, we'll need them soon ;-)


m
