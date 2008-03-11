From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 07/10] builtin-archive: mark unused prefix "unused_prefix"
Date: Tue, 11 Mar 2008 11:38:09 -0400
Message-ID: <76718490803110838p1cdc30a8vb9792d81ddf62a0d@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103446.GA8983@laptop>
	 <alpine.LSU.1.00.0803111432370.3873@racer.site>
	 <fcaeb9bf0803110750rd70a303r3fc522b326ea93b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6Z1-0005e8-Hj
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbYCKPiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbYCKPiM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:38:12 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:49581 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYCKPiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:38:11 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1681076rnb.15
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cWZ/pfMqkYg99c8G1/is6dfamF29ubpxrnvDIYf/B0s=;
        b=ZU1ppHzaZQWMkV1jY2EwgTrvIGiVRX7Lsf0V5cNtpX6vRSFImVa6428j6Eren+HXsgqL/FWO91nQ3btHtXta9UYqhsGEX/kAcryR2VDgPvBDmW33OcHptfwZrrQm3mAeAUJ1KLH0CKB4wZ1yGdhahylrjzWtvzL+70CNIaArOsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d9wl2XkH4M8f48tDoKyGIDY5aTsoYFN/JfRWPwJ5kRVLpKYtzuCq7R7wDSZDA0NAxosDqhq1vPaliSvHY5i3WMRDDBYBB/YhWC4GzYOYkbGjpJpQg4xrOWr9ZMsUH4vblAfpFSLiJ3xAOvp6XZjAMIMqDfZpE+E8teyTh3GacOQ=
Received: by 10.114.78.1 with SMTP id a1mr5468457wab.36.1205249889656;
        Tue, 11 Mar 2008 08:38:09 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Tue, 11 Mar 2008 08:38:09 -0700 (PDT)
In-Reply-To: <fcaeb9bf0803110750rd70a303r3fc522b326ea93b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76868>

I hate to make this request, but Gmail seems unable to decode messages
which are "Content-Disposition: inline" + "Content-Transfer-Encoding:
base64". The message body shows up completely blank in the Gmail web
interface. (I wonder if it is due to the footer that Majordomo appends?)

I've reported this is a bug to Gmail, but since I imagine I'm not the
only one using Gmail to read this list, and since so far your messages
seem to be the only ones sent this way, can I ask that you configure
your MUA to not send messages this way, if possible?

Much appreciated,

j.
