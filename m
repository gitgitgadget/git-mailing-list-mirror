From: Junio C Hamano <gitster@pobox.com>
Subject: GSoC applicants: discuss other applicants patches, perhaps?
Date: Thu, 5 Mar 2015 23:44:08 -0800
Message-ID: <CAPc5daV7Dv8K8itmQhdf1CG-opMVw7DYyheHdcdL0r_9zFQR-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 08:44:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTmvy-0000tI-4b
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 08:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbbCFHo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 02:44:29 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39653 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbCFHo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 02:44:28 -0500
Received: by obcwp18 with SMTP id wp18so7809043obc.6
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 23:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=b9triAwOCh25sYdAHK0y8g6coANsp33FN3RnWWnXiME=;
        b=hZr+sPSosipXwyZJ3VKi65glIb3OvXnfChWV7nXNQ9kHP50mhMAiCOfKZR33QxGfsR
         UWgJx6qxIXuWeVVdBu5GGuU2TVpjvDk0+NfdtHdh6XOZvF0uIWSIB/4fXih0xjXsZFwV
         prRU89xwhp6sJyRJr4/z3ELEDrewMTrWjoOV/t9HUWiCKdg3MmpRoWetlU9a9QNwnGh2
         p54aWKYeJ64LvqOVjIkgk0XwrO6EHBst4GuOWLioL7qt0c/0g20E5DzUPBitF2h7UMiR
         xzMlp5v2qhEGUD/VUAIdKFpXyKfVaFFVC9xQfRF6/MxOBB1pMfRsY3WHavCUL6qeCxti
         JtuQ==
X-Received: by 10.60.84.163 with SMTP id a3mr9916675oez.55.1425627868258; Thu,
 05 Mar 2015 23:44:28 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Thu, 5 Mar 2015 23:44:08 -0800 (PST)
X-Google-Sender-Auth: NrHXlDPCxlLfUBBdeSSgPUnk68w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264893>

The objective of GSoC program is to learn how to work on
projects as a part of an open source community, and working
in Git project is not only about writing your own patches.
Constructively critiquing design and implementation of
patches by other people is also an important skill you need
to learn in order to effectively collaborate with others.

So, if you have time and inclination, it would be beneficial
to read and understand other applicants' patches, think if
you agree that the problem they are trying to solve is worth
solving, the approach they are taking is the best way (or
if you think of a better way to solve it), etc., and respond
to their patches with the result of your thinking as a review.

What do mentors and others think?
