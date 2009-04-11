From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 06/10] send-email: References: should only reference 
	what is actually sent
Date: Sat, 11 Apr 2009 17:42:55 -0500
Message-ID: <b4087cc50904111542v37898b53we755ab044621ddab@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	 <loom.20090411T214618-958@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 00:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lslw6-0007Fa-Sw
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 00:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbZDKWm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 18:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbZDKWm5
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 18:42:57 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:55242 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbZDKWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 18:42:57 -0400
Received: by ewy9 with SMTP id 9so1633535ewy.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZTBxetA+0DANAwItIR2ffh3CvNXCIescXDMcN4A8Xi4=;
        b=kCY8txwwqdqjzCsSjxuPt/d5eWiiR/3heO76FV+Jxf4+z+IyWTJJ3XYSYvRaKrnM+N
         O7k8zKRz8qYpLhSa6yB42K3+9RbszQBzstxoLZ4gcm7NufYO9x1khts31uYRBJMshhiQ
         dKo2cetOH0BHyduSitc26SbgfByMFyCY69ChQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xY407x4jUrhF2hORLu3QmGwjjUoIiwhInuhpq4AsjG6HM0lb/Msq8L9kQgU36UdBm2
         qfu1mYPIWXM+kd2RUlbcIcPLKRKsL5h7aitfFN6V3F2YeSPid9JBM2+UjScPzPnQFX/6
         D6hX0LJ/xYpph6d+5kjdd+vmabumL0xKUAW+w=
Received: by 10.210.82.2 with SMTP id f2mr1339525ebb.49.1239489775554; Sat, 11 
	Apr 2009 15:42:55 -0700 (PDT)
In-Reply-To: <loom.20090411T214618-958@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116358>

On Sat, Apr 11, 2009 at 16:52, Stephen Boyd <bebarino@gmail.com> wrote:
> Michael Witten <mfwitten <at> gmail.com> writes:
>
>>
>> +# returns 1 of the message was sent, 0 otherwise.
>
> s/of/if/

Woops! Thanks!
