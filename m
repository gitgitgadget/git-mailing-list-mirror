From: <dag@cray.com>
Subject: Re: [Announce] libgit2 v0.17.0
Date: Wed, 23 May 2012 10:37:48 -0500
Message-ID: <nngy5oi3o37.fsf@transit.us.cray.com>
References: <CAFFjANQ_kfRc8LhZD4nxeYmRML6i5dQEskUv3Caz7GmnvZi2Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <libgit2@librelist.org>, <git-dev@github.com>,
	<git@vger.kernel.org>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Wed May 23 17:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXDdf-0000Ik-ID
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 17:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320Ab2EWPiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 11:38:03 -0400
Received: from exprod6og117.obsmtp.com ([64.18.1.39]:57971 "EHLO
	exprod6og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965223Ab2EWPiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 11:38:01 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob117.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT70EUqcSSLPRFpdqTXS5MRxSmiP6yKCW@postini.com; Wed, 23 May 2012 08:38:00 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.247.3; Wed, 23 May
 2012 10:37:51 -0500
In-Reply-To: <CAFFjANQ_kfRc8LhZD4nxeYmRML6i5dQEskUv3Caz7GmnvZi2Jw@mail.gmail.com>
	(Vicent Marti's message of "Sat, 19 May 2012 02:00:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198298>

Vicent Marti <vicent@github.com> writes:

> Hello everyone,
>
> A new libgit2 release is here. This one is huge (most new features to
> date). Check out the diff API. It's shiny.

This is cool.  I've wanted this for a while.  How do you ensure that the
operation of libgit2 matches that of git proper?  Is there any plan to
slowly convert git commands over to a libgit2 implementation?

                             -Dave
