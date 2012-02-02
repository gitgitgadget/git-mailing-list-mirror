From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: Workflow for git dev
Date: Thu, 2 Feb 2012 16:25:33 +0100
Message-ID: <CAH6sp9OGPe-d-E9qF5C5rbV9h5gVJ=MqhvqjcZkC=8DSntuq=w@mail.gmail.com>
References: <CALDO3MKFdZ85w5uJEcZ6dkC7SNXxKi7BAb7r78ciFzmNdjo7eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Tom Michaud <tom.michaud@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 16:25:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsyXc-0004YN-3W
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 16:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab2BBPZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 10:25:35 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:33471 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab2BBPZe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 10:25:34 -0500
Received: by qafk1 with SMTP id k1so1644600qaf.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 07:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aU1xepX+tmk1y2mPK8hH47DUzWmcIc+2d6V0JdKjkhA=;
        b=advMPDg7IBUfVTk95EbNGRoyTJR39/o+TaAAP+jY/eBJFMBLfD70G2MthvcoAASx5q
         6k9bbAsH//hEe3QtH1CDP7e0Hh/xT5KctJKzDj+jDs+fsYIbmcdLt0W6oY+AHnXWR+0n
         ms7SmolqctpHDklj3oVgA8WRpmkcj/3vKicKs=
Received: by 10.224.179.13 with SMTP id bo13mr4530911qab.58.1328196333546;
 Thu, 02 Feb 2012 07:25:33 -0800 (PST)
Received: by 10.224.204.74 with HTTP; Thu, 2 Feb 2012 07:25:33 -0800 (PST)
In-Reply-To: <CALDO3MKFdZ85w5uJEcZ6dkC7SNXxKi7BAb7r78ciFzmNdjo7eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189653>

On Thu, Feb 2, 2012 at 3:59 PM, Tom Michaud <tom.michaud@gmail.com> wrote:

> Would someone kindly point me to a document that describes the
> workflow Junio et al use to develop git?

Two notable documents in git.git are Documentation/SubmittingPatches
and Documentation/CodingGuidelines.

Hope that helps.

Frans
