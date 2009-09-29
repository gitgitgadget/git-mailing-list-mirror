From: Ben Bennett <benbennett@gmail.com>
Subject: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 09:20:34 -0500
Message-ID: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 16:21:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsdZJ-0006xM-Pm
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 16:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbZI2OUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 10:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZI2OUc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 10:20:32 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:54116 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZI2OUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 10:20:31 -0400
Received: by pxi32 with SMTP id 32so4344545pxi.4
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=9GMpdYg4NZXPJmjxiQv2lVfUd83KNpuPeQFTEFNqw9I=;
        b=Tra/o5kufdVIHr66rW6Q3unpbgz6GGGVpQEaFODfwDE+6COl+425iblZeEXVBsxhWq
         8wKyqPl06rPsQ5JVPj3JMcrjni4vlAi/HAZ7vIcs6Q2fp0nd5jUcEznwQ7wsh85ce+Cu
         mGoT3j/8vt2WLK/2CAq6zN/B9ZRD4/zVVoN3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QQjiBYeVU5Ewi/Zvv3hmp03Ec+2yasitip45VTsM6NrqwL7FkzrV5oxrEpS+K7dUrf
         PTpytH9IbkkLOW8y/v5/zniV0uGsIH64QtFPkEpa6CT9EDIv3H7IYu02Wx/pVNQgNswj
         rNLfqBlq83bmcdf3UEXEF9zWIO9kZ20yAklhk=
Received: by 10.140.225.2 with SMTP id x2mr173307rvg.263.1254234034771; Tue, 
	29 Sep 2009 07:20:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129303>

Is there any escape sequence for the @ symbol when cloning?


Thanks,
Ben
