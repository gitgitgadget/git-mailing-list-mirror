From: Thiago Farina <tfransosi@gmail.com>
Subject: multiple source file extensions
Date: Fri, 1 May 2015 21:40:58 -0300
Message-ID: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 02 02:41:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoLUP-0004lL-42
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 02:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbbEBAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 20:40:59 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33855 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbEBAk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 20:40:59 -0400
Received: by oiko83 with SMTP id o83so80192695oik.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=YNpmaUSBTpdLwZ45H601CvywiwwJvcziQrLg6+W9VJ8=;
        b=TTuRYwbhPpE4W3Djd2pf5TJe6Z2DGHrHIS+SpQ79NdSdtdBEB0YQ6o2R1tDPRHmRTS
         BRAjZgM2aWbeefO6zcqCeRYi8TbG7Rb3HsYY6C3pUrwAnoWoYawPTS0oQjRDWn2ab7Q0
         ++kJAx2I1we+uXYf99WBDo6biDM6NtHj/2rseM4cb+dX7A5+QKtAxQAeoO+VdXK7+WEj
         0IEVqbHI0HrcGGsRUQWTuQabyYMku2TPt5LyUKTEdzWL6hwD4G4RLFiKEWmIfLER2z74
         Dlvb63bKr5MzVuLCANZF64rcTXqfqq18SpaeJV8u5zSqKHbvrhrhQ9tJkFyb96Jow5PO
         PCIg==
X-Received: by 10.60.60.70 with SMTP id f6mr7671050oer.8.1430527258287; Fri,
 01 May 2015 17:40:58 -0700 (PDT)
Received: by 10.202.80.136 with HTTP; Fri, 1 May 2015 17:40:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268203>

Hey!

How do I tell 'git grep' to search only in .cc, .cpp and .h files?

>From http://gitster.livejournal.com/27674.html it seems possible to do
some filter, but in this article grep is told to search only in C
source files.

Bye!

-- 
Thiago Farina
