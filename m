From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: GSoC 2015 is over
Date: Tue, 1 Sep 2015 23:13:57 +0530
Message-ID: <CAOLa=ZQOgvoL6kHFjJmoVzedXtSqUw5K7OAcVC5Yvs7hYua3kw@mail.gmail.com>
References: <vpq8u8qw047.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:44:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpbk-0004Om-D5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbbIARo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 13:44:28 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33144 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbIARo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 13:44:27 -0400
Received: by obbbh8 with SMTP id bh8so5867862obb.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JKeYE5oaG399YdFaaOTCjmlpmcWUXumAtLa4GP8Nl7k=;
        b=H3R0Uzad7gzor76use+EADrRLu/CmE3Mfl44kkLR8cC3M0XajwQzv9WRh4XFedT8eU
         ji5PknPZg7CadZLCfBKdiCyCbvDrJKmU8CN3IxNONJAPrOeI99IBsgbESuoxFw0Hb61T
         viiB/tyTUN7NnEWvnhy0qsWrvlv8NRzWo6u70YoirXrLa4eYHwMMZoq24QymN4tZN5M4
         qpBRqhFjJoOCCFUsv6EcByB4cHh5CKqS9/y0s7HgFNajaqLkHtsbM3WD7quSFlI51VwK
         qRar26HQFGJAUT6mZBND87PgZtjDq4oz+SmgJjaFtm6ENxDq9escz23hQ3rDxqH0HEHB
         M74Q==
X-Received: by 10.182.81.98 with SMTP id z2mr17578942obx.70.1441129466844;
 Tue, 01 Sep 2015 10:44:26 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 1 Sep 2015 10:43:57 -0700 (PDT)
In-Reply-To: <vpq8u8qw047.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277001>

On Tue, Sep 1, 2015 at 10:25 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Hi,
>
> The Google Summer of Code 2015 is officially over. We had two students
> (Paul and Karthik), and both of them passed. 100 % success :-).
>

Congrats Paul :)

> I didn't follow closely Paul's work, but we now have C builtins for
> "pull" and "am" (both in master) instead of shell scripts. Karthik
> worked on the unification of "for-each-ref", "tag" and "branch". We
> already have more options for "for-each-ref". tag and branch are being
> ported to use the same library code as "for-each-ref" (2 patch series
> under review).
>
> I consider this GSoC as a great success and a pleasant experience.
> Congratulation to Paul and Karthik, and a warm "thank you" to everybody
> who contributed: administrators, mentors, reviewers, and obviously
> Junio! (not to mention Google, who made all this possible)
>
> Thanks all!
>

Thanks to everyone for helping us through this. Especially my mentors
Christian Couder and Matthieu Moy, thanks for guiding me through the project
and sparing time for reviews and suggestions, also thanks to everyone else for
their suggestions over the course of the project, especially Junio and Eric :)

Theres still a lot to do with respect to the project, and I dedicate myself to
finishing it completely. And even continue contributing to Git even after that.

Has been a pleasant experience overall.

-- 
Regards,
Karthik Nayak
