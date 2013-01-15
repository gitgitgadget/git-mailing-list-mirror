From: Chris Rorvick <chris@rorvick.com>
Subject: Re: What's cooking in git.git (Jan 2013, #06; Mon, 14)
Date: Tue, 15 Jan 2013 00:10:34 -0600
Message-ID: <CAEUsAPZrp=racc4mY7thugPvGPhH9B_wNPwNx6HkvqUMnXzJ_Q@mail.gmail.com>
References: <7vehhn8kub.fsf@alter.siamese.dyndns.org>
	<7v1udn6tdg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 07:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuzje-00083P-JE
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 07:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab3AOGKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 01:10:37 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59360 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab3AOGKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 01:10:35 -0500
Received: by mail-lb0-f179.google.com with SMTP id gm13so3544743lbb.10
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 22:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=hos8DLrUEx4gUrZkGIq9vGJtBemDZWNI0Apx5e/i6H4=;
        b=xXP41mWZLvbW+p/rcziqyUk3Whge3LAoDbaeAOn2/EmJfIq7PQ0T7/SmQ4zNdO3frs
         CaSRLdOVYS02VmXYZzHOWS8u0YP2G8dsX8LyqFPfa7kPvTKhdEFLsT2IfS+Dbq/WCTVk
         ulndKt6UV9xo2mBhdvQSq2wQbQz+2TXo1yBceXeXMnqUpR841FTGwwlHs9T5/GbgyhW5
         Nn0HFuCtJmrWgRwjpOyObD4PJj87NrLOkFZcBvHxPJDki29DQvyySOVFz9SxuR5uLj7t
         bdethHvqnj4fknYy/K2TX6UAb32hVPb4q1dBg6CQr06/4H0PohnW8ki7T2Rj+b2+f25q
         E+3w==
Received: by 10.152.113.165 with SMTP id iz5mr29458879lab.50.1358230234266;
 Mon, 14 Jan 2013 22:10:34 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Mon, 14 Jan 2013 22:10:34 -0800 (PST)
In-Reply-To: <7v1udn6tdg.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 4mHM5VTqYc94KWzG0HpAve6hpSk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213595>

On Mon, Jan 14, 2013 at 9:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I converted one of Chris's follow-up test tweaks to this to
> illustrate how it can be done without breaking tests for the
> original cvsimport, but didn't do all of them.  Chris, is this a
> foundation we can work together on top?

Sure, looks straightforward and makes things easier.

Thanks,

Chris
