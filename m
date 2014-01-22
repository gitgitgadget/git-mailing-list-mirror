From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Anomalous AUTHOR and DOCUMENTATION sections in manpages
Date: Wed, 22 Jan 2014 18:39:52 +0700
Message-ID: <CACsJy8AEU2dQPNknazRxEh12MNd=3Kw3+_tc3meS_Bs961ERkA@mail.gmail.com>
References: <52DFA9EF.4080309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 22 12:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5wAY-0000zd-MN
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 12:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbaAVLk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 06:40:26 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:37321 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaAVLk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 06:40:26 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so253408qab.23
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kl/e3XYl1WDCCvxwS2Pn982LA2+fmxgGfPWFo5j4fTA=;
        b=0MXfJYkZQdXV37BTeZ7nLAAMO1Qypf001sMx3FpdNtX+cwMdPO51788h7x+T1LNneM
         K4TBfQffXYYs6HhtqK06AnXd63mLsTrqxJFHwCtZVTo8CYr7Na/HR52zCXocMFvBvVoH
         RUQX2NS6cjvstDMSY2hQCq/ereMCFu/jI/UeFaP8OIlzv8Ykl17ufqysFSae2JpHO81r
         CfLWsbJF+wPBi1SA2rcxpGgpy+qSp8mc6jVLtgtTQYOOwLbNUdSqwavQWzWTW5TAj4Bw
         npZHGEoIlkfnQyPL5vx/qeNMUuRClBCQXLeMyFgN6jscf0Lm6CzfZ4AsTUtmHm5VKp5X
         H3Sg==
X-Received: by 10.224.123.14 with SMTP id n14mr1422669qar.78.1390390823422;
 Wed, 22 Jan 2014 03:40:23 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Wed, 22 Jan 2014 03:39:52 -0800 (PST)
In-Reply-To: <52DFA9EF.4080309@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240822>

On Wed, Jan 22, 2014 at 6:22 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> These sections are inconsistent with the other manpages and seem
> superfluous in a project that has, on the one hand, a public history
> and, on the other hand, hundreds of contributors.  Would the mentioned
> authors (CCed) consent to the removal of these sections?

No problem from me.
-- 
Duy
