From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Tue, 12 Feb 2008 11:40:14 -0500
Message-ID: <76718490802120840r4a45c016k4cccf321f68893ce@mail.gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	 <1202696664-1565-1-git-send-email-jaysoffian+git@gmail.com>
	 <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 17:41:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOyBk-0003QT-Rc
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 17:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758838AbYBLQkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 11:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758314AbYBLQkS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 11:40:18 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:31944 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072AbYBLQkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 11:40:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2861787wah.23
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wXJuYIfOa30cC+C1iKQDW2xu1e7twXXJ8gA/lzoTX7s=;
        b=MjMApa2kEAYL028gx1fQMfZHnmDWw2a5raVKgfZsKTPj7ibJNyK+7XQWy6wa7+1K+3ZSqWA6NgjEBc5/7yf3GjYpi69Cc8uaVdojUP0Uut8pUwQd+dvoyKQfEe6KaW9oy8mGqOdSlqSIR4nB/ITpEtUgW986XbcaQfQ5eXfaxgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GbBr0Xxrb5Y2n63ddjsQt7XUcw3pt2E15fj5+n6QHlljB1wnbp5yuIjosQE6DHM6bvHxlRz5YqRtigo+lXslIev3SfCFzlO36CIslCVE/0iw0JwsxGGdUG1bSBJ/ukxMyMob+X1Dq9jMczWuUn8F4PafE4Bez8etDRsf1bqYtNw=
Received: by 10.114.79.1 with SMTP id c1mr1649628wab.148.1202834414547;
        Tue, 12 Feb 2008 08:40:14 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Tue, 12 Feb 2008 08:40:14 -0800 (PST)
In-Reply-To: <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73673>

On Feb 10, 2008 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Also I wonder why the check for SECURITYSESSIONID your original
> had is not good enough for this Mac specific customization?

Christian,

Any thoughts on Junio's patch vs the original?

http://thread.gmane.org/gmane.comp.version-control.git/73149/focus=73354

j.
