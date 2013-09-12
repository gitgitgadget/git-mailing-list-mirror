From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH/RFC] Developer's Certificate of Origin: default to COPYING
Date: Thu, 12 Sep 2013 19:24:54 -0400
Message-ID: <20130912232454.GA5279@thunk.org>
References: <1379023862-29953-1-git-send-email-rhansen@bbn.com>
 <xmqqy571n05d.fsf@gitster.dls.corp.google.com>
 <CA+55aFyQZ8EiOg+CZy-KMaX0Hnkdmvq1+8b9p6uuMuHAUzYaAg@mail.gmail.com>
 <52324B1A.2030001@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 01:25:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKGG1-000890-G4
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 01:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab3ILXZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 19:25:01 -0400
Received: from imap.thunk.org ([74.207.234.97]:59296 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616Ab3ILXZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 19:25:00 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1VKGFq-0003Ob-Qm; Thu, 12 Sep 2013 23:24:54 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 18D5B5804B0; Thu, 12 Sep 2013 19:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=mail;
	t=1379028294; bh=nWMfHsRL59FntUUYyu+1OajeE5MjPbqGc1hBHH6QEC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fc4ctOY6e/rtAa20v6pviOlmcpqDQSHEo6OXmt7gQrmI3ulWSd7K8jtoVzQzAwdmO
	 HnSLt/gXuYrAFDIAxxO9RIazqYjxcKnYzpHltzr2J0PqZlUUmgWls8CtuyWXn+pxju
	 WguiGefEs6ialOTwgi9jmQZ2YpjVKrG3xDeKApxY=
Content-Disposition: inline
In-Reply-To: <52324B1A.2030001@bbn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234712>

I certainly wouldn't recommend messing with the text of the DCO
without first consulting some lawyers.  There should also be some
centralized coordination about any changes in the text and the version
number.

						- Ted
