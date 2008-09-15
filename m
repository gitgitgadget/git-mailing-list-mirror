From: david@lang.hm
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Sun, 14 Sep 2008 20:39:59 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0809142038190.19489@asgard.lang.hm>
References: <200809031607.19722.jnareb@gmail.com>  <200809112214.18366.jnareb@gmail.com> <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 05:44:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf50J-0000gO-OY
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 05:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbYIODjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 23:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYIODjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 23:39:09 -0400
Received: from mail.lang.hm ([64.81.33.126]:39573 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764AbYIODjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 23:39:08 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m8F3d4uh004776;
	Sun, 14 Sep 2008 20:39:04 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <fcaeb9bf0809140345n11d41430ma9b4096c66776b0c@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95871>

On Sun, 14 Sep 2008, Nguyen Thai Ngoc Duy wrote:

> On 9/12/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>  15) Do you miss features in git that you know from other SCMs?
>>     If yes, what features are these (and from which SCM)?
>>     (Open ended text - Essay)
>>
>>  Total respondents       1046 (some/many of them wrote 'no')
>>  skipped this question   1249
>>
>>  This is just a very quick summary, based on a first few pages of
>>  responses, Full analysis is I think best left for after closing the
>>  survey, because I think this would be a lot of work...
>>
>>  So here is preliminary list, or rather beginning of one:
>>   * sparse/partial checkout and clone (e.g. Perforce)
>
> Have not read the survey result, but do you recall what is the most
> used term for sparse/partial checkout? What SCMs do sparse/partial
> checkout? I think it could be usable as it is now in my
> will-be-sent-again series, but I don't really know how people want it
> to from that.

the most common use-case is people who want to follow a project but (at 
least think that they) don't need the history. so they want to save 
time/bandwideth/disk space by not downloading things they don't need.

David Lang
