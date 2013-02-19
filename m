From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Documentation/git-commit.txt: correct a few minor
 grammatical mistakes
Date: Mon, 18 Feb 2013 23:29:24 -0800
Message-ID: <20130219072924.GJ19757@elie.Belkin>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <1361247427-438-4-git-send-email-drafnel@gmail.com>
 <20130219064304.GG19757@elie.Belkin>
 <CA+sFfMf8juf0rQh6S2sW=_LmsbhPc=c+erVppsZbAw-+h-4CqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7heH-0008RL-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 08:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478Ab3BSH3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 02:29:31 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38163 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab3BSH3a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 02:29:30 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so3278053pad.7
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 23:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4arT9XXplWfAzDCiU56/6EFXAJzulQ1r+zN6xSL1xnw=;
        b=D/Su1Gba7X+9+k34t4A1v3E0CaTAs/4lgF0Ey+btdjnfL9XUjCKgwx15AmDKIQIMA9
         era4NtEOdBwZGMJZFFVBSpuar8jNYS+15Ita1jmsHmbRq6HpJsRSrs3la6LOo/jOCKgz
         kyMzGHmjBfc2pL6SopofB5eslmVozsih6KEOEjzkjsLHS9Fbc00HtU41jQZ+sct7j1Yh
         ihCbpawiNpZ7eswT4bghajisDheTNqKRdWjasTR6ZpNa0lTwF1GgC57ENOC1Xwl8Z6dZ
         o/bHvvG1Wid8bpSOKJvkDzWo+Rn9pOgaByxmFWJf+o/tB4x1R3D0syK5FsnbWyIQmAJz
         mRFA==
X-Received: by 10.68.47.39 with SMTP id a7mr37361476pbn.155.1361258970146;
        Mon, 18 Feb 2013 23:29:30 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ab1sm17127680pbd.37.2013.02.18.23.29.27
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 23:29:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+sFfMf8juf0rQh6S2sW=_LmsbhPc=c+erVppsZbAw-+h-4CqQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216570>

Brandon Casey wrote:

> Hmm, I think the original text was more confusing than I realized.  I
> think we should reorder the cleanup modes, placing "default" last, and
> then describe default in terms of either strip or whitespace depending
> on whether an editor will be spawned.

Sounds good to me. :)
