From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4 2/4] notes: add tests for --commit/--abort/--strategy exclusivity
Date: Wed, 12 Aug 2015 02:36:26 +0200
Message-ID: <CALKQrgfC7Bko9NOtbCrNwq2UfS6tStsO0scN150NixEfFbmc8A@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
	<1439326641-9447-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPK22-0000kd-M0
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 02:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbbHLAge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 20:36:34 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:51693 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbbHLAge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 20:36:34 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZPK1w-000LIz-Lx
	for git@vger.kernel.org; Wed, 12 Aug 2015 02:36:32 +0200
Received: by ykdz80 with SMTP id z80so1657440ykd.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 17:36:26 -0700 (PDT)
X-Received: by 10.13.215.74 with SMTP id z71mr15113577ywd.151.1439339786922;
 Tue, 11 Aug 2015 17:36:26 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 11 Aug 2015 17:36:26 -0700 (PDT)
In-Reply-To: <1439326641-9447-3-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275751>

On Tue, Aug 11, 2015 at 10:57 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Add new tests to ensure that --commit, --abort, and --strategy are
> mutually exclusive.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>

Reviewed-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
