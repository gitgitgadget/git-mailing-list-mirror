From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 20:08:04 -0400
Message-ID: <CAEBDL5WJ=thZ6oUUxJ=VuvX6J+FCyzKcX2XKz209A=cTnbStew@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<7v38sod1kn.fsf@alter.siamese.dyndns.org>
	<20130611182936.GM22905@serenity.lan>
	<51B771D5.6030809@alum.mit.edu>
	<4F402D814F814EB19B8617BB31B3C473@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jun 12 02:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYbk-0001yG-9w
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 02:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab3FLAIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 20:08:07 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:39703 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FLAIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 20:08:06 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so6307713wes.40
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=aXxxFtoy7i3Lr4v52GwvkJiKT9O9DUq//PLXkiuEx/8=;
        b=PT2IujnurydEj+pHbNtH9jUBY3FksiWyiAcAe/b4QW5NUnA/542Gmj3pHF7/D2LsZK
         p9vHrVBNo1gdEER2kNaupPXJbdzF9/uzl4fpJTlaHy9MCnOeUE0lX4aLViA3cOlLUsSt
         a14pvb8SWCMYPG0/cjYEemdvcAVu3z/7htGiWEcc+QYy/z6UgzOVzOpa2Mp7d0Y84N3W
         TQEfrYzvloFjDU5KcJJ332Xv+2H8KWGZkTah1w8mSmPSszj7nK1qLeATRmBTJlWeOBAZ
         RDiDhSGcWZcp69Kk+HzWIaUv5wWqVPqT6cjMfvdFDJaglTLPHnWKbgHbfJsmKud7pgbR
         cEzg==
X-Received: by 10.180.74.10 with SMTP id p10mr2851316wiv.39.1370995685059;
 Tue, 11 Jun 2013 17:08:05 -0700 (PDT)
Received: by 10.180.24.5 with HTTP; Tue, 11 Jun 2013 17:08:04 -0700 (PDT)
In-Reply-To: <4F402D814F814EB19B8617BB31B3C473@PhilipOakley>
X-Google-Sender-Auth: nKLvRRiBKIkZblPsotJ6Dk0Jzo0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227579>

On Tue, Jun 11, 2013 at 3:46 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Michael Haggerty" <mhagger@alum.mit.edu>
> Sent: Tuesday, June 11, 2013 7:52 PM
> [...]
>
>>
>> That's a very good point (and a good illustration, too).  How do you
>> like the new second and third sentences below?
>>
>> * When reviewing other peoples' code, be tactful and constructive.
>> Remember that submitting patches for public critique can be very
>> intimidating
>
>
> I found this to be true. The tone on the list could at times feel un-helpful
> (to the new person). It is almost as if it is an initiation - those on the
> list know the protocols, and new folk either arrive like a bull in a china
> shop, or more likely, timidly push the patch under the door and run away
> (and variations in between) - some never push out their (drafted) patch.

Interesting!  I've had the opposite opinion.  I've often been
surprised at how much constructive feedback has been given, and the
thoughtfulness of the reviewers to offer up alternative solutions,
show examples, etc.  Junio, Jeff, and especially Jonathan have been
particularly good on that front--at least those are some of the
regulars that stick out in my mind.  Overall, I've been pretty happy
with the community, and while I haven't contributed much, I generally
enjoy reading the emails.  I feel like I learn something new all the
time. :-)

-John
