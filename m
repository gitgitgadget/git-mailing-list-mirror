From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Time to flush Mr. Hammano?
Date: Mon, 21 Jan 2008 14:12:09 +0000
Message-ID: <e1dab3980801210612k3c0a52d1l8d868a2b49f4b558@mail.gmail.com>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
	 <20070624192215@qkholland.gmail.com> <47949BBD.6060308@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Quim K Holland" <qkholland@gmail.com>,
	"gi mailing list" <git@vger.kernel.org>
To: "Rogan Dawes" <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Jan 21 15:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGxOM-0003OP-Vd
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 15:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYAUOMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 09:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbYAUOMO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 09:12:14 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:25473 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYAUOMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 09:12:14 -0500
Received: by wr-out-0506.google.com with SMTP id c49so551111wra.1
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CN9Ff2tkb+C6EHcsgXbgm4h9bUWsHd2axLeZdGuP3uo=;
        b=u/BmIH+dlUbLZn906acFheo5CCi6J56PcvAi9zTczX2akCxTJxsO3Al+uQNVNTaNOo6UMynJzQ2Ge5K95z3AjHDW+IU8dKrEgYN0ckhsYWXpXew54kiF7MvP6CdMwZrKXBucUp44bA26lXIfTey71S5ohO1SdAbcOrfC/qWgmW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WAkcvtCtiZIFPjjdFUfa0U3nGtXJBAwC3b/CWlp3oj+/g5s8JfkDdU+IbUFtCSlh9261hWwF36AlTpOo6r/yiRltXs6Z36ksztgNBVtIVUuY+85gx3LCaFNjcdEiSme0SrT1/IRQ3XdlM2apmCps/Z+RMf6SJszDcv6im+PVogs=
Received: by 10.150.96.10 with SMTP id t10mr2329105ybb.1.1200924729957;
        Mon, 21 Jan 2008 06:12:09 -0800 (PST)
Received: by 10.150.53.15 with HTTP; Mon, 21 Jan 2008 06:12:09 -0800 (PST)
In-Reply-To: <47949BBD.6060308@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71282>

One other point no-one has mentioned: even if Junio were to be doing
more stabilisation than normal in a project (and I don't think he is),
version control software is one of those things like a filesystem
where paying attention to stability is really important. Unlike a
buggy music player (say), a buggy git could destroy everything up to
your last backup.

I appreciate all the work everyone in the community is currently doing
on stabilisation.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
