From: David Chanters <david.chanters@googlemail.com>
Subject: Re: git-grep to operate across whole repository and not just CWD?
Date: Mon, 28 Feb 2011 01:16:37 +0000
Message-ID: <AANLkTin2i4vNQymMgBejMa1TDQNxO62i71FYEereqSnC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 02:16:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtrjG-0001mv-JX
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 02:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1B1BQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 20:16:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46292 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1B1BQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 20:16:37 -0500
Received: by iwn34 with SMTP id 34so2675839iwn.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 17:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=acyJj6UqY4rjO7aZMLncJJlus81a1aWu5LkwZJhOEWA=;
        b=W7apJuQmPnigX/z90SLrKOSFelK6GAvhMDrNCkn2MQtpZ9EB3xTT8Gh95sZkH1pckI
         nG54ODT/fsexF8nl4bcoOSlwLBKB9EZXQNDZG/BhcawtEU/o8+2JM+nE0du2TFPbKRfc
         b0Aj+mUUVlTsGvGKTPLz49Ex9gdjW+MCB9L7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=pGO4IyBjV8mgSLANuiHCdWb65L5hGnKdkU8f1+UIiGlcVgNV7PSoxOLmh/rtUsjcSL
         i9nomYT/+oKgrYiKPIy0F89AXmKZY2MfP9HrCWkSwnKLY8bXQheGzpOUVC73iFxJ49BW
         1P6IJGmt5vA9InoFOS56pp+P6/x1vci4MLOlM=
Received: by 10.42.155.70 with SMTP id t6mr1247494icw.418.1298855797238; Sun,
 27 Feb 2011 17:16:37 -0800 (PST)
Received: by 10.42.170.196 with HTTP; Sun, 27 Feb 2011 17:16:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168064>

On 28 February 2011 00:17, David Chanters <david.chanters@googlemail.com> wrote:
> Hi all,
>
> [ Please Cc me as I am not subscribed to this list, thanks. ]

Sorry -- I mistyped the subject.  That should be "whole", not "who".

David
