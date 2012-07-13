From: "~ ~" <j08691@gmail.com>
Subject: Grammar fix
Date: Fri, 13 Jul 2012 15:26:41 -0400
Message-ID: <CA+_9odBe+vj7FSFoALscpU+XRDS9y5_SGo=Van5nLpHqVJj1mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 21:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SplWJ-0002BH-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 21:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933528Ab2GMT0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jul 2012 15:26:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52272 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933523Ab2GMT0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2012 15:26:42 -0400
Received: by eaak11 with SMTP id k11so1180516eaa.19
        for <git@vger.kernel.org>; Fri, 13 Jul 2012 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=QcCFKO67f0vqRgtI0IssVqXsVqkCqAzKvK1BeQKbqEg=;
        b=kZKV1MULtnYJaSLQec4CGKPFaT/svV4DK7V/Q7UIVByGeZKDJtmejK/vgxUQkpP0yh
         vaqZXgmpXlI8qocZU2sa9NaTOOkGYV5aX5yjm/jpxKnnHFiLyFts/A4p8UD73ScdCtHr
         09CJtz7ZnK8WjQL0SQ0VKZphgDnDfMfVjOD8baOp16eQ2bMhIzAME/ZOkxDGuvWEw7qY
         NCz17+ChKZZTI2vuQv6NEPE9JrNLlhTgvg+Labg+8WnR4dxgB+OyQN9eHCNVjDT9HvJn
         WlUoQFHRkel70JXO2DA5iABJEXu9etF/EeTAIjah6VRuOz2uECGhPM+MZ5d9SfUicCNM
         epFg==
Received: by 10.14.22.67 with SMTP id s43mr578662ees.153.1342207601535; Fri,
 13 Jul 2012 12:26:41 -0700 (PDT)
Received: by 10.14.177.7 with HTTP; Fri, 13 Jul 2012 12:26:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201417>

On page:  http://git-scm.com/book/en/Git-Basics-Undoing-Things

The line: "What if you realize that you don=92t want to keep your
changes to the benchmarks.rb file? How can you easily unmodify it =97
revert it back to what it looked like when you last committed (or
initially cloned, or however you got it into your working directory)?"

Should be: "What if you realize that you don=92t want to keep your
changes to the benchmarks.rb file? How can you easily unmodify it =97
revert to what it looked like when you last committed (or initially
cloned, or however you got it into your working directory)?"

"revert back" is redundant. You can't revert forward.

Cheers.
